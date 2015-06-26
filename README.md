# Referral Spam Blacklist

> Blacklist referral spam on a server level with Nginx.

There are two primary components to this repository:

1. `blacklist.conf` which is drop-in ready to begin blocking referral spam
2. `generate.sh` which is able to combine multiple blacklists to produce a clean, workable master blacklist

## Downloading

If you just want the blacklist, see the [latest release](https://github.com/chauncey-garrett/referral-spam-blacklist/releases). Otherwise, if you need to make changes to the blacklist, clone the repo with:

```sh
git clone --recursive https://github.com/chauncey-garrett/referral-spam-blacklist.git
```

## Usage

With `blacklist.conf` in `/etc/nginx`, include it globally from within `/etc/nginx/nginx.conf`:

```conf
http {
	include blacklist.conf;
}
```

Add the following to each `/etc/nginx/site-available/your-site.conf` that needs protection:

```conf
server {
	if ($bad_referer) {
		return 444;
	}
}
```

## Combining other blacklists

`src/generate.sh` can be used to expand and/or update `blacklist.conf` from multiple blacklists. It will parse several lists, sorting them alphabetically and removing duplicate entries, before generating a new `conf` file.

Subsequent lists should be formatted in the same manner as `src/blacklist-piwik.txt`. Furthermore, additional lists should be named in a similar manner: `blacklist-name1.txt` and `blacklist-name2.txt`.

1. Add the additional list(s) to `src/`.
2. Edit `src/generate.sh` to add the new file(s) to the array
3. Run `./generate.sh` from within the `src/` directory

The newly generated `blacklist.conf` will be located in the root of the git repo.

## Updating Piwik's blacklist

> NOTE: Piwik's blacklist is included via a submodule. Assuming you cloned the repository with `git clone --recursive`, these instructions will work.

From the root of the git directory:

```sh
cd external/piwik-referrer-spam-blacklist/
git pull origin master
```

Finally, you can update `blacklist.conf` with `generate.sh`:

```sh
cd src/
./generate.sh
```

## Testing if the blacklist works

Check that the proper response (403) is given:

```sh
curl --referer "http://www.referral-spam.com" http://yoursite.com
```

## Blacklist contributions

Contributions to the blacklist itself should be directed to [piwik/referrer-spam-blacklist](https://github.com/piwik/referrer-spam-blacklist).

If you know of another (vetted) referral spam blacklist that should be considered as well, please let me know by [opening an issue](https://github.com/chauncey-garrett/referral-spam-blacklist/issues).

## Like it?

If you've found this project useful, would you consider sending your support?

- [Contribute Feedback](https://github.com/chauncey-garrett/referral-spam-blacklist/issues) or a [Pull Request](https://github.com/chauncey-garrett/referral-spam-blacklist/pulls)
- [Provide Support](http://chauncey.io/donate/)
- [Give Bitcoin](https://www.coinbase.com/ChaunceyGarrett)

## Author

*The author of this module should be contacted via the [issue tracker](https://github.com/chauncey-garrett/referral-spam-blacklist/issues "chauncey-garrett/referral-spam-blacklist/issues").*

| [![](http://www.gravatar.com/avatar/81e1334c20c8dc25dbf3fee88dc1879c.jpg?s=150&r=g)](http://chauncey.io) |
| :------------------------------------------------------------------------------------------------------: |
| [Chauncey Garrett](http://chauncey.io) - [@chauncey_io](http://twitter.com/chauncey_io)                  |

