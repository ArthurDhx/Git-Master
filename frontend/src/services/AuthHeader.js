import StorageService from './StorageService';

export default function AuthHeader () {
    return {
        Authorization:
      'Bearer ' + StorageService.get('credentials')
    };
}
