// ignore_for_file: constant_identifier_names

enum ImagesEndpoint {
  FETCH_IMAGE,
  STORE_IMAGE,
  DELETE_IMAGE;

  const ImagesEndpoint();

  String route() {
    switch (this) {
      case ImagesEndpoint.FETCH_IMAGE:
        return 'retrieveImage';
      case ImagesEndpoint.STORE_IMAGE:
        return 'storeImage';
      case ImagesEndpoint.DELETE_IMAGE:
        return 'deleteImage';
    }
  }
}
