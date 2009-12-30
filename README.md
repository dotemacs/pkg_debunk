Verify the installed ports/packages
======================================

Run:

    for i in $(ls /var/db/pkg)
    do
       pkg_debunk.rb ${i}
    end

will return the names of packages which have their files missing e.g.

    ca_root_nss-3.12.4 ca_root_nss-3.12.4:
      missing /usr/local/etc/ssl/cert.pem
    ruby18-gems-1.3.5:
      missing /usr/local/lib/ruby/gems/1.8/cache/sources-0.0.2.gem
      missing /usr/local/lib/ruby/gems/1.8/gems/sources-0.0.2/lib/sources.rb
      missing /usr/local/lib/ruby/gems/1.8/specifications/sources-0.0.2.gemspec




