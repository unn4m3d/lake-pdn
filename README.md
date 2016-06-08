lake-pdn
==

Lake-PDn - Pretty download progress bar for lake. Can be used without lake

Usage
--

```ruby
  use :pdn #or require 'lake/plugins/pdn'

  #...
  Lake::PDn::download("http://example/file.zip","aaa.zip"){
    |stat|
    # Stat has 4 fields : total_size, downloaded_size, average_speed, current_speed
    puts stat.average_speed
  }

  Lake::PDn::pretty_dn("http://example/file.zip","aaa.zip")
```
