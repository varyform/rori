# Releasing

1. CI is green on `main` (`bundle exec rake test`, `bundle exec rubocop`).
2. Bump `Rori::VERSION` in `lib/rori/version.rb`; in `CHANGELOG.md` rename
   "Unreleased" to the version and date.
3. Check what ships: `gem build rori.gemspec && tar -xOf rori-*.gem data.tar.gz | tar -tz`
   (app, config, lib, vendor, README, LICENSE, CHANGELOG — no test/ or docs/).
4. Commit ("Release x.y.z"), tag `vx.y.z`, push with tags.
5. `gem push rori-x.y.z.gem` (MFA is required by the gemspec metadata).
6. In rori-demo: `gem "rori", "~> x.y"` instead of the GitHub source,
   `bundle install`, commit.
