from PIL import Image, ExifTags
import psycopg2

def lambda_handler(event, context):
    print("This is the event {}".format(event))
    print("This came from uploaded code.")