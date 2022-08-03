import re
# Extract Emails


def extract_email(text):
    return re.findall('[\w\.-]+@[\w\.-]+', text)
# Extract Phone Numbers


def extract_phone(text):
    return re.findall(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$', text)
