ivansin.build:
	@docker build -t model-maker .

ivansin.create:
	@./docker/run_scripts/run.bash

ivansin.create.nvidia:
	@./docker/run_scripts/runNvidiaGPU.bash

ivansin.up:
	@docker start ivansin-dk

ivansin.down:
	@docker stop ivansin-dk

ivansin.restart:
	@docker restart ivansin-dk

ivansin.logs:
	@docker logs --tail 50 ivansin-dk
	
ivansin.shell:
	@docker exec -it ivansin-dk bash

ivansin.remove:
	@docker container rm ivansin-dk