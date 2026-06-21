fmt:
	stylua lua/ --config-path .stylua.toml

test:
	@out=$$(nvim --headless +qa 2>&1); \
	if [ -n "$$out" ]; then \
		printf '%s\n' "$$out"; \
		echo "FAIL: nvim emitted errors on startup"; \
		exit 1; \
	fi; \
	echo "ok: config loaded with no errors"

.PHONY: fmt test

