# Referral Spam Blacklist

> Blacklist referral spam on a server level with Nginx.

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
	if($bad_referer) {
		return 444;
	}
}
```

## Combining other blacklists

`./src/generate.sh` can be used to expand and/or update `blacklist.conf` from multiple blacklists. It can parse several lists, sorting them alphabetically and removing duplicate entries, before generating a new `conf` file. These lists should be formatted in the same manner as `./src/blacklist-piwik.txt`.

To use it, any additional lists should be named `blacklist-name1.txt` and `blacklist-name2.txt`, so they work well with `.generate.sh`.

1. Add the additional list(s) to `./src/`.
2. Edit `./src/generate.sh` to add the new file(s) to the array
3. Run `./generate.sh` from within the `./src/` directory

The newly generated `blacklist.conf` will be located in the root of the git repo.

## Testing the blacklist works

Check that the proper response (403) is given with:

```sh
curl --referer "http://www.spam.com" http://yoursite.com
```

## Blacklist contributions

Contributions to the blacklist itself should be directed to [piwik/referrer-spam-blacklist](https://github.com/piwik/referrer-spam-blacklist).

If you know of another (vetted) referral spam blacklist that should be considered as well, please let me know by opening an issue.

## Like it?

If you have feature suggestions, please open an [issue](https://github.com/chauncey-garrett/referral-spam-blacklist/issues "chauncey-garrett/referral-spam-blacklist/issues"). If you have contributions, open a [pull request](https://github.com/chauncey-garrett/referral-spam-blacklist/pulls "chauncey-garrett/referral-spam-blacklist/pulls"). I appreciate any and all feedback.

## Author(s)

*The author(s) of this module should be contacted via the [issue tracker](https://github.com/chauncey-garrett/referral-spam-blacklist/issues "chauncey-garrett/referral-spam-blacklist/issues").*

  - [Chauncey Garrett](https://github.com/chauncey-garrett "chauncey-garrett")

