FROM python:3.9

RUN apt-get update && \
    apt-get install -y libsndfile1
RUN apt-get update && \
    apt-get install -y portaudio19-dev
RUN apt-get update && \
    apt-get install -y espeak

WORKDIR /srv
COPY ./requirements.txt /srv/requirements.txt

RUN python3 -m venv venv && . venv/bin/activate
RUN pip3 install -r requirements.txt

COPY ./run_model_downloader.py /srv/run_model_downloader.py
COPY ./run_controllable_GUI.py /srv/run_controllable_GUI.py
COPY ./InferenceInterfaces /srv/InferenceInterfaces
COPY ./Layers /srv/Layers
COPY ./Preprocessing /srv/Preprocessing
COPY ./TrainingInterfaces /srv/TrainingInterfaces
COPY ./Utility /srv/Utility

CMD ["/srv/venv/bin/python", "run_model_downloader.py && run_controllable_GUI.py"]