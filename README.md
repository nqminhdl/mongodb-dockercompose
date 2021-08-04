# MongoDB ReplicaSet Docker Compose

Install mongo shell on MacOS

```
brew tap mongodb/brew
brew install mongodb-community-shell
```

Here are steps to bring up MongoDB ReplicaSet with docker compose

```
# Expose environment variable for docker-compose
1. export LOCAL_IP=`ipconfig getifaddr en0`
2. echo $LOCAL_IP
# Run docker-compose in the background
3. docker-compose up -d
# Connect to mongodb replicaset cluster
4. mongo "mongodb://boss:boss@localhost:27011,localhost:27012,localhost:27013/admin?replicaSet=rs0&readPreference=secondaryPreferred"
```
