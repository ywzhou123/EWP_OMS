# -*- coding: utf-8 -*-
from django.shortcuts import  render,render_to_response,get_object_or_404
from django.http import HttpResponseRedirect,HttpResponse,JsonResponse
from django.core.urlresolvers import reverse
from django.contrib import auth
from django.contrib.auth.decorators import login_required  #setting: LOGIN_URL = '/auth/login/'
from django.shortcuts import redirect
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth.forms import  PasswordChangeForm


def login(request):
    username = request.POST.get('username','')
    password = request.POST.get('password','')
    user = auth.authenticate(username=username, password=password)
    if user is not None and user.is_active:
        auth.login(request, user)
        return redirect('auth:index')
    else:
        return render(request,'AUTH/login.html')

@login_required
def index(request):
    return render(request, 'AUTH/index.html')

@login_required
def user(request):
    return render(request,'AUTH/user.html')

@login_required
def password(request):
    ok=0
    if request.method == 'POST':
        form = PasswordChangeForm(user=request.user, data=request.POST)
        if form.is_valid():
            form.save()
            update_session_auth_hash(request, form.user)
            ok=1
    else:
        form = PasswordChangeForm(user=request.user)
    return render(request, 'AUTH/password.html', {'form':form,'ok':ok})

def logout(request):
    auth.logout(request)
    return HttpResponseRedirect(reverse('auth:login'))