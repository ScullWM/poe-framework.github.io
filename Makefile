LESS_SRCS = template/less/*.less
FONT_SRCS = template/node_modules/font-awesome/fonts/*
JS_SRCS = template/node_modules/jquery/dist/jquery.min.js template/node_modules/highlight.js/lib/highlight.js

.PHONY: doc doc-clean preview
.SUFFIXES:

preview: vendor doc
	vendor/bin/couscous preview

doc: template/css/* template/fonts/* template/js/*

doc-clean: doc
	rm -rf .couscous/generated/{node_modules,less,yarn.lock,package.json}

template/css:; mkdir -p $@
template/fonts:; mkdir -p $@
template/js:; mkdir -p $@

template/css/%: template/css template/node_modules $(LESS_SRCS)
	template/node_modules/.bin/lessc template/less/main.less template/css/all.min.css

template/fonts/%: template/fonts $(FONT_SRCS)
	cp $(FONT_SRCS) template/fonts

template/js/%: template/js $(JS_SRCS)
	cp $(JS_SRCS) template/js

template/node_modules: template/yarn.lock
	cd template && yarn

template/yarn.lock: template/package.json
	cd template && yarn

vendor: composer.lock

composer.lock: composer.json
	composer install