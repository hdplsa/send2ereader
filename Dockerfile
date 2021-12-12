FROM node:16-alpine

EXPOSE 3001

RUN mkdir /code
WORKDIR /code
ADD . /code/

# Create uploads folder
RUN mkdir uploads

# Install GO
RUN wget https://go.dev/dl/go1.17.4.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.17.4.linux-amd64.tar.gz && \
    rm go1.17.4.linux-amd64.tar.gz 
ENV PATH="/usr/local/go/bin:${PATH}"

# Install Kepubify
RUN wget https://github.com/pgaskin/kepubify/releases/download/v4.0.2/kepubify-linux-64bit
RUN mkdir /usr/local/kepubify
RUN mv kepubify-linux-64bit /usr/local/kepubify/kepubify
RUN chmod +x /usr/local/kepubify/kepubify
ENV PATH="/usr/local/kepubify:${PATH}"

# Install Python (requirement to install Calibre)
RUN apk --update --no-cache python3
# Install Calibre

# Install all the required packages
RUN npm install 
CMD ["node", "/code/index.js"]