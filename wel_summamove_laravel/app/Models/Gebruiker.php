<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;

class Gebruiker extends Model
{
    protected $table = 'gebruikers';

    protected $fillable = ['gebruikers',
    'geregistreerd'];

    public function prestaties() {
        return $this->hasMany(Prestatie::class, 'gebruiker_id');
    }
}
