requires 'Attribute::Handlers';
requires 'Sub::Install';

on 'test' => sub {
    requires 'Test::More';
};

on 'develop' => sub {
    requires 'Archive::Tar::Wrapper';
    requires 'Dist::Zilla';
    requires 'Dist::Zilla::Plugin::ReadmeAnyFromPod';
    requires 'Dist::Zilla::Plugin::CheckChangeLog';
    requires 'Dist::Zilla::Plugin::FakeRelease';
    requires 'Dist::Zilla::Plugin::Git::GatherDir';
    requires 'Dist::Zilla::Plugin::Git::NextVersion';
    requires 'Dist::Zilla::Plugin::Git::Tag';
    requires 'Dist::Zilla::Plugin::PkgVersion';
    requires 'Dist::Zilla::Plugin::Prereqs::FromCPANfile';
    requires 'Dist::Zilla::PluginBundle::Basic';
    requires 'Dist::Zilla::PluginBundle::Filter';
    requires 'Dist::Zilla::PluginBundle::GitHub';
};
