<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
public function up()
{
    Schema::create('gebruikers', function (Blueprint $table) {
        $table->id();
        $table->string('gebruikersnaam', 191)->unique(); // max lengte 191
        $table->boolean('geregistreerd')->default(false);
        $table->timestamps();
    });
}



    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('gebruikers');
    }
};
