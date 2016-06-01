from django.contrib import admin

# Register your models here.
from .models import *
admin.site.register(IDC)
admin.site.register(SystemType)
admin.site.register(HostGroup)
admin.site.register(HostDetail)
admin.site.register(Server)
admin.site.register(Host)
admin.site.register(Network)