FROM p4lang/behavioral-model:latest
LABEL mantainer="David Araújo <davidaraujo.github.io"

ENV PORT_NUM=4

COPY . .

RUN apt-get update && \
    apt-get install -y iproute2 iputils-ping dos2unix

RUN chmod +x start_switch.sh 

ENTRYPOINT ./start_switch.sh ${PORT_NUM} ${GRPC_PORT}