<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Category;

class CategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Definición de las categorías a insertar en la base de datos
        $categories = [
            [
                'nombre' => 'Tecnología',
                'descripcion' => 'Productos y servicios relacionados con tecnología',
                'estado' => true,
            ],
            [
                'nombre' => 'Hogar',
                'descripcion' => 'Artículos para el hogar y decoración',
                'estado' => true,
            ],
            [
                'nombre' => 'Deportes',
                'descripcion' => 'Equipamiento y accesorios deportivos',
                'estado' => true,
            ],
            [
                'nombre' => 'Moda',
                'descripcion' => 'Ropa y accesorios de moda',
                'estado' => false,
            ],
            [
                'nombre' => 'Salud',
                'descripcion' => 'Productos de salud y bienestar',
                'estado' => true,
            ],
            [
                'nombre' => 'Educación',
                'descripcion' => 'Libros, cursos y material educativo',
                'estado' => true,
            ],
            [
                'nombre' => 'Entretenimiento',
                'descripcion' => 'Juegos, películas y entretenimiento',
                'estado' => false,
            ],
        ];

        // Recorre cada categoría y la inserta en la base de datos
        foreach ($categories as $category) {
            Category::create($category);
        }
    }
}