IMAGE=time-control-bot
CLOCKIN_USER=user
CLOCKIN_PASSWORD=super_secure_password

PHONY += build
build:
	docker build -t $(IMAGE) .

PHONY += shell
shell: build
	docker run -it -e CLOCKIN_USER=$(CLOCKIN_USER) -e CLOCKIN_PASSWORD=$(CLOCKIN_PASSWORD) $(IMAGE) /bin/sh

PHONY += start
start: build
	docker run -it -e CLOCKIN_USER=$(CLOCKIN_USER) -e CLOCKIN_PASSWORD=$(CLOCKIN_PASSWORD) $(IMAGE) /bin/sh -c "python bot.py start"

PHONY += lunch
lunch: build
	docker run -it -e CLOCKIN_USER=$(CLOCKIN_USER) -e CLOCKIN_PASSWORD=$(CLOCKIN_PASSWORD) $(IMAGE) /bin/sh -c "python bot.py lunch"

PHONY += stop
stop: build
	docker run -it -e CLOCKIN_USER=$(CLOCKIN_USER) -e CLOCKIN_PASSWORD=$(CLOCKIN_PASSWORD) $(IMAGE) /bin/sh -c "python bot.py stop"
