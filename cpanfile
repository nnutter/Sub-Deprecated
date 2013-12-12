requires 'Attribute::Handlers';
requires 'Sub::Install';

on 'test' => sub {
    requires 'Test::More';
};

on 'develop' => sub {
    requires 'Dist::Zilla';
    requires 'Dist::Zilla::Plugin::FakeRelease';
    requires 'Dist::Zilla::Plugin::Git::Tag';
    requires 'Dist::Zilla::Plugin::NextVersion::Semantic';
    requires 'Dist::Zilla::Plugin::NextVersion::Semantic';
    requires 'Dist::Zilla::Plugin::Prereqs::FromCPANfile';
    requires 'Dist::Zilla::Plugin::Prereqs::FromCPANfile';
    requires 'Dist::Zilla::Plugin::PreviousVersion::Changelog';
    requires 'Dist::Zilla::Plugin::PreviousVersion::Changelog';
    requires 'Dist::Zilla::PluginBundle::Basic';
    requires 'Dist::Zilla::PluginBundle::Filter';
    requires 'Dist::Zilla::PluginBundle::GitHub';
};
