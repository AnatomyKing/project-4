<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Oefening extends Model
{
    protected $table = 'oefeningen';

protected $fillable = [
    'naam',
    'beschrijving_nl',
    'beschrijving_en',
    'afbeelding_url'
];


    public function prestaties() {
        return $this->hasMany(Prestatie::class, 'oefening_id');
    }
}
