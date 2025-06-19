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
    Schema::create('prestaties', function (Blueprint $table) {
        $table->id();
        $table->foreignId('gebruiker_id')->constrained('gebruikers')->onDelete('cascade');
        $table->foreignId('oefening_id')->constrained('oefeningen')->onDelete('cascade');
        $table->date('datum');
        $table->time('starttijd')->nullable();
        $table->time('eindtijd')->nullable();
        $table->integer('aantal')->default(1);
        $table->timestamps();
    });
}



    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('prestaties');
    }
};
