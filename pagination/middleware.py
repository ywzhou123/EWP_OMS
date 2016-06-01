def get_page(self):
    """
    A function which will be monkeypatched onto the request to get the current
    integer representing the current page.
    """
    try:
        return int(self.GET['page'])
    #RemovedInDjango19Warning: `MergeDict` is deprecated, use `dict.update()` instead.
    #self._request = datastructures.MergeDict(self.POST, self.GET)
    except (KeyError, ValueError, TypeError):
        return 1

class PaginationMiddleware(object):
    """
    Inserts a variable representing the current page onto the request object if
    it exists in either **GET** or **POST** portions of the request.
    """
    def process_request(self, request):
        request.__class__.page = property(get_page)