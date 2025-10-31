# Weather App

This is a toy weather app that maps addresses to forecasts.
It has no persistence layer, only caching. `config.cache_store` is set to `:memory_store` to avoid dependencies, but in a real deployment memcached or Redis would be better.

Run development server as usual:
```
bundle install
bin/rails server
```

# Design Notes
Using zip codes as cache keys is an awkward requirement, although it does narrow scope to US-only. Using rounded versions of the actual geographic coordinates would be far preferrable, since they are evenly distributed.

I could find no free API that mapped addresses directly to forecasts. Instead, we use the US Census API to map addresses to coordinates (and zip codes, since users can give city and state instead), which the Weather.gov API can use to retrieve forecasts.

I chose to use basic CSS without a framework in the interest of time. I believe the app is still usable without any styles.

I use the VCR gem to record and mock the HTTP requests in non-system tests. This allows the test suite to be run without internet access.
