from pydantic import BaseSettings


class Settings(BaseSettings):
    mongo_url: str

    class Config:
        env_file = ".env"


settings = Settings()
