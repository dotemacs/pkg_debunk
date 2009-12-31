Verify the installed ports/packages
======================================

To test all the installed packages run it with no arguments:


       ./pkg_debunk.rb 


Or for a particular package provide it as a argument:


       ./pkg_debunk.rb ca_root_nss-3.12.4


The results will look like this, displaying the package names and
their missing files:

    ca_root_nss-3.12.4 ca_root_nss-3.12.4:
      missing /usr/local/etc/ssl/cert.pem
    ruby18-gems-1.3.5:
      missing /usr/local/lib/ruby/gems/1.8/cache/sources-0.0.2.gem
      missing /usr/local/lib/ruby/gems/1.8/gems/sources-0.0.2/lib/sources.rb
      missing /usr/local/lib/ruby/gems/1.8/specifications/sources-0.0.2.gemspec




