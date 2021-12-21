from django.urls import path, include
from rest_framework.routers import DefaultRouter
# Match URLS automatically for all of the actions in our viewset

from recipe import views

router = DefaultRouter()
router.register('tags', views.TagViewSet)

app_name = 'recipe'

urlpatterns = [
    path('', include(router.urls))
]
