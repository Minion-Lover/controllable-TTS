FROM python:3.9

RUN sudo apt-get update
RUN sudo apt-get install -y libsndfile1
RUN sudo apt-get install portaudio19-dev
RUN sudo apt-get install espeak

WORKDIR /srv
COPY ./requirements.txt .

RUN python3 -m venv venv && . venv/bin/activate
RUN python3 -m pip install --no-cache-dir -r requirements.txt --upgrade pip

COPY ./run_model_downloader.py /srv/run_model_downloader.py
COPY ./run_controllable_GUI.py /srv/run_controllable_GUI.py
COPY ./InferenceInterfaces /srv/InferenceInterfaces
COPY ./Layers /srv/Layers
COPY ./Preprocessing /srv/Preprocessing
COPY ./TrainingInterfaces /srv/TrainingInterfaces
COPY ./Utility /srv/Utility

CMD ["python", "run_model_downloader.py"]
CMD ["python", "run_controllable_GUI.py"]
