from rest_framework import serializers

from core.models import Tag, Ingredient, Recipe


class TagSerializer(serializers.ModelSerializer):
    """Serializer for tag objects"""
    
    class Meta:
        model = Tag
        fields = ('id', 'name')
        read_only_fields = ('id',)


class IngredientSerializer(serializers.ModelSerializer):
    """Serializer for ingredient objects"""
    
    class Meta:
        model = Ingredient
        fields = ('id', 'name')
        read_only_fields = ('id',)
        

class RecipeSerializer(serializers.ModelSerializer):
    """Serialser for recipe objects"""
    
    ingredient = serializers.PrimaryKeyRelatedField(
        many=True,
        queryset=Ingredient.objects.all()
    )
    tag = serializers.PrimaryKeyRelatedField(
        many=True,
        queryset=Tag.objects.all()
    )
    
    class Meta:
        model = Recipe
        # fields stands for what we want to return in the serializer
        fields = ('id', 'title', 'ingredient', 'tag', 'time_minutes',
                  'price', 'link')
        read_only_fields = ('id',)
        

class RecipeDetailSerializer(RecipeSerializer):
    """Serialize a recipe detail"""
    ingredient = IngredientSerializer(many=True, read_only=True)
    tag = TagSerializer(many=True, read_only=True)
    
    
class RecipeImageSerializer(serializers.ModelSerializer):
    """Serializer for uploading images to recipes"""
    
    class Meta:
        model = Recipe
        fields = ('id', 'image')
        read_only_fields = ('id',)
        
    