dir := $(shell pwd)

install:
	sudo echo "SUPERUSER"

	@sudo iptables -D INPUT -p tcp -m tcp --dport 4444 -m conntrack --ctstate NEW -j ACCEPT || :
	sudo iptables -A INPUT -p tcp -m tcp --dport 4444 -m conntrack --ctstate NEW -j ACCEPT

	sudo touch /usr/local/bin/push
	@sudo chmod 0755 /usr/local/bin/push
	@echo "#!/bin/bash" | sudo tee /usr/local/bin/push >/dev/null
	@echo "dir=\"${dir}\"" | sudo tee --append /usr/local/bin/push >/dev/null
	@cat ./src/push.sh | sudo tee --append /usr/local/bin/push >/dev/null

	sudo touch /usr/local/bin/pop
	@sudo chmod 0755 /usr/local/bin/pop
	@echo "#!/bin/bash" | sudo tee /usr/local/bin/pop >/dev/null
	@echo "dir=\"${dir}\"" | sudo tee --append /usr/local/bin/pop >/dev/null
	@cat ./src/pop.sh | sudo tee --append /usr/local/bin/pop >/dev/null

	@if test -f ./config/people.sh; \
	then \
		echo "Skip people"; \
	else \
		touch ./config/people.sh; \
		echo "me=\"127.0.0.1\"" | tee ./config/people.sh >/dev/null; \
	fi

	@echo ""
	@echo "Done!"
