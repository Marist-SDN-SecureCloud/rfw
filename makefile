intro:
	@echo "\n					LCARS RFW"

rfw_image:intro
	@docker build -t rfw .

rfw_publish: rfw_image
	@docker tag rfw dgisolfi/lcars_rfw:latest
	@docker push dgisolfi/lcars_rfw


run_rfw:rfw_image
	@docker run --rm --name rfw_prod --privileged -p7390:7390 -v/Users/daniel/git/rfw:/rfw rfw
