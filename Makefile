SERVICE_NAME := goinfre-nomad.service
LOCAL_BIN_DIR := $(HOME)/.local/bin
SYSTEMD_USER_DIR := $(HOME)/.config/systemd/user
SERVICE_LOGIN_SCRIPT := goinfre-nomad-login.sh
SERVICE_LOGOUT_SCRIPT := goinfre-nomad-logout.sh

install:
	mkdir -p $(LOCAL_BIN_DIR)
	cp $(SERVICE_LOGIN_SCRIPT) $(LOCAL_BIN_DIR)
	cp $(SERVICE_LOGOUT_SCRIPT) $(LOCAL_BIN_DIR)
	chmod +x $(LOCAL_BIN_DIR)/$(SERVICE_LOGIN_SCRIPT)
	chmod +x $(LOCAL_BIN_DIR)/$(SERVICE_LOGOUT_SCRIPT)
	mkdir -p $(SYSTEMD_USER_DIR)
	cp $(SERVICE_NAME) $(SYSTEMD_USER_DIR)/
	systemctl --user daemon-reload
	systemctl --user enable $(SERVICE_NAME)
	systemctl --user start $(SERVICE_NAME)

.PHONY: install