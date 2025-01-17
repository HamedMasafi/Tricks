import QtQuick 2.0
import AsemanQml.Base 2.0
import AsemanQml.Network 2.0
import "../globals" 1.0

BaseRequest {
    id: req
    contentType: NetworkRequest.TypeJson
    url: baseUrl + "/notifications/tags/" + _tag

    property string _tag

    function doRequest() {
        _networkManager.get(req)
    }
}
