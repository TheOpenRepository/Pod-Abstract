package Pod::Abstract::Filter::clear_podcmds;
use strict;

use base qw(Pod::Abstract::Filter);

sub filter {
    my $self = shift;
    my $pa = shift;

    my ($first_node) = $pa->select("/(0)");
    my @pod_cmds = $pa->select(
        "//pod[!<<#cut]"
        );
    foreach my $pod_cmd (@pod_cmds) {
        # The start of the document is in cut mode, even if there is
        # no text there, so if the lead node is an =pod node don't
        # strip it.
        $pod_cmd->detach
            unless $pod_cmd->serial == $first_node->serial;
    }

    return $pa;
}

1;