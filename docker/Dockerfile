FROM p4lang/behavioral-model:latest
LABEL mantainer="David Araújo <davidaraujo.github.io"

ENV PORT_NUM=4
ENV GRPC_PORT=9559

EXPOSE ${GRPC_PORT}

COPY . .

RUN apt-get update && \
    apt-get install -y iproute2 iputils-ping dos2unix

# Make sure EOF characters are cleaned and script is executable
RUN dos2unix start_switch.sh
RUN chmod +x start_switch.sh 

ENTRYPOINT ./start_switch.sh ${PORT_NUM} ${GRPC_PORT}