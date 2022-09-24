FROM python:3.8

WORKDIR /usr/local/sample-api
ADD sample-api .
ADD sample-api/app ./app


RUN python -m pip install --upgrade pip
RUN pip install pipenv && pipenv install --system --deploy

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]
EXPOSE 80