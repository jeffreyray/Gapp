package Gapp::TableMap;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;

# array of Gapp::TableCell objects
has 'cells' => (
    is => 'ro',
    isa => 'ArrayRef',
    lazy_build => 1,
);

# number of columns in table ( used when creating Gtk2::Table )
has 'col_count' => (
    is => 'rw',
    isa => 'Int',
    writer => '_set_col_count',
    default => 0,
);

# number of rows in table ( used when creating Gtk2::Table )
has 'row_count' => (
    is => 'rw',
    isa => 'Int',
    writer => '_set_row_count',
    default => 0,
);

# the ascii representation of the table
has 'string' => (
    is => 'rw',
    isa => 'Str',
    default => '',
    trigger => 'analyze',
);

# the ascii table, cleaned up and split into an array
has '_rows' => (
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [ ] },
);

# the horizontal vertices
has '_rasterx' => (
    is => 'rw',
    isa => 'HashRef',
    default => sub { { } },
);

sub add_rasterx {
    my ( $self, $point ) = @_;
    $self->rasterx->{$point} = 1;
}

# the vertical vertices
has '_rastery' => (
    is => 'rw',
    isa => 'HashRef',
    default => sub { { } },
);

sub add_rastery {
    my ( $self, $point ) = @_;
    $self->_rastery->{$point} = 1;
}

# the width of the ascii table in chars
has '_xunits' => (
    is => 'rw',
    isa => 'Int',
    default => 0,
);

# the height of the ascii table in chars
has '_yunits' => (
    is => 'rw',
    isa => 'Int',
    default => 0,
);

sub _build_cells {
    my ( $self ) = @_;
    
    $self->_find_rasters;
    
    my @cells;
    my @rasterx = sort { $a <=> $b } keys %{ $self->_rasterx };
    my @rastery = sort { $a <=> $b } keys %{ $self->_rastery };
    
    my $ypos = 0;
    for my $r ( $self->_rows ) {
        my $row = $r;
        
        # skip rows with no fields (borders and spacers);
        $ypos++, next if $row !~ /[|^_']/; 
        
        # left_x, right_x, left_attach, right_attach
        my ( $lx, $rx, $la, $ra ) = ( 0, 0, 0, 0 );
        
        # remove leading table border character and remember it
        $row =~ s/^(.)//;
        my $lead_char = $1;
        
        # split row into field parts
        for my $field ( split /[|+'_^~]/, $row ) {
            $rx = $lx + 1 + length $field;
            
            # calculate span of this field
            my $spanx = 0;
            for my $x ( @rasterx ) {
                $spanx++ if $x >= $lx && $x < $rx;
                last if $x > $rx;
            }
            
            # calculate right attach using cell span
            $ra = $la + $spanx;
            
            # process field only if doesn't span from previous row
            my $last_row = $self->_rows->[$ypos-1];
            if ( $ypos > 0 && substr ( $last_row, $lx + 1, 1 ) =~ /[-=>%\[\]]/  ) {
                
                
                # calculate top/bottom attach by searching for bottom of field
                my ( $ta, $ba ) = ( 0, 0 );
                
                # skip first line, which defines no columns
                my $seeky;
                for ( $seeky = 1; $seeky < $self->_yunits; ++$seeky ) {
                    
                    if ( $seeky < $ypos and $self->_rastery->{$seeky} ) {
                        $ta++;
                        $ba++;
                    }
                    elsif ( $self->_rastery->{$seeky} ) {
                        $ba++;
                    }
                    
                    # out here if hit end of field
                    last if $seeky > $ypos and substr( $self->_rows->[$seeky], $lx+1, 1) =~ /[-+=\[\]\%]/;
                    $field .= "\n". substr($self->_rows->[$seeky], $lx+1, $rx-$lx-1) if $seeky > $ypos;
                    
                }
                
                # create cells ( if field not emptry )
                if ( $field =~ /\S/ ) {
                    
                    my $cell = Gapp::TableCell->new(
                        left => $la, right => $ra, top => $ta, bottom => $ba,
                        hexpand => $self->_find_xexpansion( $lx+1, $ypos, $rx ),
                        vexpand => $self->_find_yexpansion( $lx, $ypos, $seeky-1 ),
                        xalign  => $self->_find_xalign( $lx+1, $ypos, $rx ),
                        yalign  => $self->_find_yalign( $lx, $ypos, $seeky-1 ),
                    );
                    
                    push @cells, $cell;
                }
            }
            
            # setup vars for next field
            $lx = $rx,
            $la = $ra;
            
        }
            
        # move on to next row
        $ypos++;
    }
    
    # store cells and table dimensions
    $self->_set_row_count( $#rastery );
    $self->_set_col_count( $#rasterx );
    return \@cells;
}

sub _build_rows {
    my ( $self ) = @_;
    
    my @rows = split /\n/, $self->string;
    @rows = map { s/^\s*//; $_ } @rows;
    @rows = map { s/\s*$//; $_ } @rows;
    
    return \@rows;
}

# traverse the rows to dermine where the rasters occur
sub _find_rasters {
    my ( $self ) = @_;
    
    my $y = 0;
    my $row_length = 0;
    for my $r ( @{ $self->_rows } ) {
        
        # if this row has + or -, then it is a layout row
        if ( $r =~ /-+/ ) {
            
            # store raster
            $self->_add_rastery( $y ); 
        }
        
        # if row has any of | ^ _ ' ~ it is a content row
        if ( $r =~ /[|^_'~]/ ) {
            
            # split on field separating characters
            my $x = 0;
            for my $field ( split /[|^_']/, $r ) {
                
                # determine and store raster
                $x += length $field;
                $self->_add_rasterx( $x );
                $x++;
            }
            
            $row_length = $x if $x > $row_length;
        }
        
        # on to the next row
        $y++;
    }
    
    $self->_set_xunits( $row_length );
    $self->_set_yunits( $y );
}


sub _find_xexpansion {
    my ( $self, $x, $y, $max_x ) = @_;

    my $char;
    my $segment = substr $self->rows->[$y-1], $x, $max_x + 1 - $x ;
    return [qw( fill expand )] if $segment =~ /[>^]/;
    return ["fill"];
}

sub _find_yexpansion {
    my ( $self, $x, $y, $max_y ) = @_;

    for my $row ( @{$self->rows}[$y..$max_y] ) {
        my $segment = substr $row, $x, 1;
        return [qw( fill expand )] if $segment eq '^';
    }

    return ["fill"];
}

sub _find_xalign {
    my ( $self, $x, $y, $max_x ) = @_;
    
    my $row = $self->rows->[$y-1];
    my $char;
    while ( $x <= $max_x ) {
        $char = substr($row, $x, 1);
        return 0   if $char eq '[';
        return 1   if $char eq ']';
        return 0.5 if $char eq '%';
        ++$x;
    }
    
    return -1;
}

sub _find_yalign {
    my ( $self, $x, $y, $max_y ) = @_;

    my $char;
    while ( $y <= $max_y ) {
        my $char = substr $self->rows->[$y], $x, 1;
        return 0   if $char eq "'";
        return 1   if $char eq '_';
        return 0.5 if $char eq '~';
        ++$y;
    }

    return -1;
}


1;
