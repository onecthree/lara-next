<?php

namespace Database\Seeders;

use App\Models\Order;
use Faker\Factory as Faker;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $faker = Faker::create();

        for( $i = 0; $i < 10; $i += 1 ) {
            Order::create([
                'name' => $faker->name(),
                'age' => $faker->numberBetween(12, 75),
            ]);
        }
    }
}
