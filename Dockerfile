FROM python:3.6-alpine3.9

RUN apk add --no-cache bash curl dbus firefox-esr fontconfig ttf-freefont xvfb

# Add gecko driver
ARG GECKODRIVER_VERSION=0.24.0
ARG GECKODRIVER_FILE=v${GECKODRIVER_VERSION}/geckodriver-v${GECKODRIVER_VERSION}-linux64.tar.gz
RUN curl -s -o /tmp/geckodriver.tar.gz -L \
  https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_FILE \
  && rm -rf /usr/bin/geckodriver \
  && tar -C /usr/bin -zxf /tmp/geckodriver.tar.gz \
  && rm /tmp/geckodriver.tar.gz \
  && mv /usr/bin/geckodriver /usr/bin/geckodriver-$GECKODRIVER_VERSION \
  && chmod 755 /usr/bin/geckodriver-$GECKODRIVER_VERSION \
  && ln -fs /usr/bin/geckodriver-$GECKODRIVER_VERSION /usr/bin/geckodriver

RUN python3 -m ensurepip
RUN pip install selenium

WORKDIR /app
ADD bot.py /app
CMD tail -f /dev/null
# CMD ["python", "./bot.py"]