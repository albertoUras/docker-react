#build phase
FROM node:16-alpine as builder
USER node
RUN mkdir -p /home/node/app
WORKDIR /home/node/app
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./
CMD ["npm","run","build"] 
#RUN npm run build
#CMD ["ls"]

FROM nginx
# Per elastic beanstalk, che vedrà questa istruzione e saprà di dover esporre la 80
EXPOSE 80
#COPY --from=builder /app/build /user/share/nginx/html
#Non trovava la cartella app/build oppure /build e ho passato tutto. All'interno del container SEMBRA ci siano solo 2 file html quindi suppongo vada bene così, ovvero che fosse il risultato voluto (ovvero non ha copiato l'altra roba dependencies e simili)
COPY --from=builder . /user/share/nginx/html