import docker

client=docker.from_env()

def count_watchdogs():
    watchdog_counter = 0
    for container in client.containers.list():
        if "davidjosearaujo/watchdog:" in container.image.tags[0]:
            watchdog_counter += 1
    return watchdog_counter

def launch_watchdog(tag="latest",num_ports=8):
    watchdog_id = count_watchdogs()
    
    # Pulling latest watchdog images
    client.images.pull("davidjosearaujo/watchdog", tag=tag)
    
    client.containers.run("davidjosearaujo/watchdog",
        name=f"watchdog_{watchdog_id}",
        cap_add=["NET_ADMIN"],
        ports={'9559/tcp': 10000+watchdog_id},
        detach=True
    )
    
    

# TESTING
if __name__ == '__main__':
    