from django.db import models


from django.db import models
from django.contrib.auth.models import User


class Posts(models.Model):
    userId = models.ForeignKey(User, on_delete=models.CASCADE)
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=100)
    body = models.TextField(max_length=512)

    class Meta:
        verbose_name_plural = 'posts'

    def __str__(self):
        return self.title

class Comments(models.Model):
    postId = models.ForeignKey(Posts,on_delete=models.CASCADE)
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100)
    body = models.TextField(max_length=512)
    email = models.EmailField()

    class Meta:
        verbose_name_plural = 'comments'

