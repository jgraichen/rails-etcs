# Rails::Etcs

A collection of patches and alternatives for Rails core classes.

## Installation

If you cannot install the gem alone you should better not use it.

## Usage

### Rails::Etcs::Application

`Rails::Etcs::Application` can be included when creating your application:

```ruby
# my-app/config/application.rb

module MyApp
  class Application < ::Rails::Application
    include ::Rails::Etcs::Application
    self.ident = 'my-app'
  end
end
```

`Rails::Etcs::Application` is tuned in several ways:

#### Application Paths

Most paths have been adjusted to allow moving static files such as `config/application.rb`, `config/routes.rb`, `config/environment.rb`, `config/initializers`, `config/environments`, `config/locales` to `app/`. You can therefore move all application code into the application directory. `config/boot.rb` could be moved manually.

This way it is possible to have an application where `config/` really only contains (end-user) configuration files.

#### XDG Base Directory Specification

The application will further respect the XDG Base Directory Specification for looking up configuration files and temp directories.

You can customize the application name via `self.ident = 'my-app'`. Configuration file by search e.g. in:

* `~/.config/my-app`
* `/etc/xdg/my-app`
* `/etc/my-app`
* `config`

`#config_for` has been patched to search for the first existing configuration file in any existing configuration directory.

The same lookup is applied for `database.yml`, `secrets.yml`, and additional
initializers and environments files.

#### `#config_for`

`#config_for` has been patched with additional functionality.

It returns the full parsed config instead of the environment key when `env: false` is passed:

```ruby
config_for('database', env: false) # => {'development' => ..., 'test' => ..., ...}
```

The additional `quiet` keyword argument can be used to suppress a file not found exception. Together with the new `yield` support you can easily handle optional configuration:

```ruby
config_for('may-exist-or-not', quiet: true) do |conf|
   # ...
end
```

## License

Rails::Etcs (c) 2018 Jan Graichen

It is free software, and may be redistributed under the terms of The MIT License (MIT).
