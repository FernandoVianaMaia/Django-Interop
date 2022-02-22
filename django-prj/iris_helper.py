from django.conf import settings
import irisnative

GBL = 'NAME'


def trigger_response(original_request_token, user):
    args = settings.IRIS_CONNECTION_ARGS
    conn = irisnative.createConnection(
        args['hostname'], args['port'], args['namespace'], args['username'], args['password'])

    # Create an iris object
    iris = irisnative.createIris(conn)

    # Set a global
    # iris.set('Response is ready', GBL, original_request_id)

    # Send deferred response
    iris.classMethodVoid(
        "djangointerop.bo.RequestServiceAccessResponse", "ProduceDeferredResponse", original_request_token, user)

    conn.close()
