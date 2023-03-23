from django.shortcuts import get_object_or_404, render
from django.shortcuts import redirect
from time import timezone
from .models import Posts
from .forms import PostForm

def index(request):
    data = Posts.objects.all()
    context = {'data' : data}
    return render(request, 'posts/list.html', context)

def detail(request, post_id):
    post = get_object_or_404(Posts, pk=post_id)
    return render(request, 'posts/detail.html', {'post': post})

def add(request):
    if request.method == 'GET':
        form = PostForm()
        return render(request, 'posts/add.html', {'form': form})
    if request.method == 'POST':
        form = PostForm(request.POST)
        if form.is_valid():
            post = form.save(commit=False)
            post.userId = request.user
            post.save()
            return redirect('posts:detail', post_id=post.id)
