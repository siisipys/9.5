<?php

namespace Database\Seeders;

use App\Models\Product;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // Create or get demo user
        $user = User::firstOrCreate(
            ['email' => 'demo@example.com'],
            [
                'name' => 'Demo User',
                'password' => Hash::make('password123'),
            ]
        );

        // Create sample products
        $products = [
            [
                'name' => 'iPhone 15 Pro Max',
                'description' => 'Latest Apple flagship smartphone with A17 Pro chip, titanium design, and advanced camera system.',
                'price' => 18999000,
                'stock' => 25,
                'image' => 'https://picsum.photos/seed/iphone/400/300',
            ],
            [
                'name' => 'MacBook Pro M3',
                'description' => 'Powerful laptop with M3 Pro chip, Liquid Retina XDR display, and all-day battery life.',
                'price' => 32999000,
                'stock' => 15,
                'image' => 'https://picsum.photos/seed/macbook/400/300',
            ],
            [
                'name' => 'Samsung Galaxy S24 Ultra',
                'description' => 'Premium Android smartphone with Galaxy AI, S Pen, and 200MP camera.',
                'price' => 19999000,
                'stock' => 30,
                'image' => 'https://picsum.photos/seed/samsung/400/300',
            ],
            [
                'name' => 'Sony WH-1000XM5',
                'description' => 'Industry-leading noise canceling headphones with exceptional sound quality.',
                'price' => 5499000,
                'stock' => 50,
                'image' => 'https://picsum.photos/seed/sony/400/300',
            ],
            [
                'name' => 'iPad Pro 12.9"',
                'description' => 'The ultimate iPad experience with M2 chip and stunning Liquid Retina XDR display.',
                'price' => 17999000,
                'stock' => 20,
                'image' => 'https://picsum.photos/seed/ipad/400/300',
            ],
        ];

        foreach ($products as $product) {
            Product::create(array_merge($product, ['user_id' => $user->id]));
        }
    }
}
