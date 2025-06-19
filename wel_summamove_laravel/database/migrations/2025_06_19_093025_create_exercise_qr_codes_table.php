<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::disableForeignKeyConstraints();

        Schema::create('exercise_qr_codes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('exercise_id')->constrained()->unique();
            $table->text('qr_value')->unique();
            $table->timestamp('created_at')->useCurrent();
            $table->index('qr_value');
        });

        Schema::enableForeignKeyConstraints();
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('exercise_qr_codes');
    }
};
