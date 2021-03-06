#!/usr/bin/python

import smtplib
from email.MIMEMultipart import MIMEMultipart
from email.MIMEBase import MIMEBase
from email.MIMEText import MIMEText
from email import Encoders
import os

mail_user = "marco@rizzoli.me.uk"
mail_pwd = os.getenv('mail_pwd')

def mail(to, subject, text):
   msg = MIMEMultipart()

   msg['From'] = mail_user
   msg['To'] = to
   msg['Subject'] = subject

   mailServer = smtplib.SMTP("smtp.zoho.com", 587)
   mailServer.ehlo()
   mailServer.starttls()
   mailServer.ehlo()
   mailServer.login(mail_user, mail_pwd)
   mailServer.sendmail(mail_user, to, msg.as_string())
   # Should be mailServer.quit(), but that crashes...
   mailServer.close()

mail("marcosofista@gmail.com",
   "Hello from python!",
     "This is a email sent with python")

