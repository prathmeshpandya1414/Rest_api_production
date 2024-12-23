
from django.urls import path, re_path
from django.urls import include
from rest_framework.routers import DefaultRouter
from . import views

router = DefaultRouter()
router.register('hello-viewset',views.HelloViewSet, basename='hello-viewset')
router.register('profile', views.UserProfileViewSet)
router.register('login',views.LoginViewSet, basename = 'login')

urlpatterns = [
    path('hello-view/', views.HelloApiView.as_view()),
    path('',include(router.urls))

]
