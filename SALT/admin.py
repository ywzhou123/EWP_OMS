from django.contrib import admin

# Register your models here.
from .models import *
admin.site.register(SaltServer)
admin.site.register(Command)
admin.site.register(Module)
# admin.site.register(TargetType)
# admin.site.register(ClientType)
admin.site.register(SvnProject)
admin.site.register(Result)