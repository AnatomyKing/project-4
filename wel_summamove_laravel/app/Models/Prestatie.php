<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Prestatie extends Model
{
    protected $table = 'prestaties';

    protected $fillable = ['gebruiker_id',
        'oefening_id',
        'datum',
        'starttijd',
        'eindtijd',
        'aantal',
    ];

    public function gebruiker() {
        return $this->belongsTo(Gebruiker::class, 'gebruiker_id');
    }
    public function oefening() {
        return $this->belongsTo(Oefening::class, 'oefening_id');
    }
}
